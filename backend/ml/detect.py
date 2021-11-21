import time

import numpy as np
import requests
import cv2

import io, zlib

from fooddata import get_product

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

cred = credentials.Certificate("../hackatum-d9e2e-firebase-adminsdk-sbcmr-3a9e9ed96b.json")
firebase_admin.initialize_app(cred)
db = firestore.client()

def encode_ndarray(np_array):  # utility function
    bytestream = io.BytesIO()
    np.save(bytestream, np_array)
    uncompressed = bytestream.getvalue()
    compressed = zlib.compress(uncompressed, level=1)  # level can be 0-9, 0 means no compression
    return compressed


we_have = {"Pepper", "Milk", "Banana", "Yoghurt", "Carrots"}


def predict_product(img):
    try:
        r = requests.post(
            "https://zerowastecustom-prediction.cognitiveservices.azure.com/customvision/v3.0/Prediction/9d829228-446c-43da-9750-fbcfb6bdaabf/classify/iterations/Iteration1/image",
            data=cv2.imencode('.jpg', img)[1].tobytes(),
            headers={"Prediction-Key": "35163ed9df2045a98dbdcd12200b9558", 'Content-type': 'application/octet-stream'})
        res = r.json()
        # print(res)
        predictions = res["predictions"]
        main_pred = None
        for pred in predictions[:3]:
            if pred['tagName'] in we_have:
                main_pred = pred
                break
        if main_pred["probability"] > 0.1:
            # print(main_pred['tagName'] + str(main_pred['probability']))
            return main_pred
    except Exception:
        return None


def analyze_pic(img):
    bboxes = find_bounding_box(img)


    for bbox in bboxes:
        x = bbox[0]
        y = bbox[1]
        w = bbox[2]
        h = bbox[3]
        cropped_img = img[y:y + h, x:x + w]
        prediction = predict_product(cropped_img)
        if prediction is not None:
            try:
                product = (get_product(prediction['tagName']))
                print(prediction['tagName'])
                db.collection('users').document('C6OvTqu5Ui4wFOjqmGRw').collection('ingredients').document(str(product["id"])).set(product)
            except Exception:
                pass
        # if prediction is not None:
        #     write_text(img, x, y, prediction['tagName'])


font = cv2.FONT_HERSHEY_SIMPLEX
fontScale = 1
fontColor = (255, 255, 255)
thickness = 1
lineType = 2


def write_text(img, x, y, txt):
    cv2.putText(img, txt,
                (x, y),
                font,
                fontScale,
                fontColor,
                thickness,
                lineType)


def find_bounding_box(img):
    wh = 320
    conf_threshold = 0.0
    nms_threshold = 0.4
    model_config = 'yolov4-p6.cfg'
    model_weights = 'yolov4-p6.weights'

    net = cv2.dnn.readNetFromDarknet(model_config, model_weights)
    net.setPreferableBackend(cv2.dnn.DNN_BACKEND_OPENCV)
    net.setPreferableTarget(cv2.dnn.DNN_TARGET_CPU)

    blob = cv2.dnn.blobFromImage(img, 0.01, (wh, wh), [0, 0, 0], 1, crop=False)
    net.setInput(blob)

    layer_names = net.getLayerNames()
    output_names = []
    for i in net.getUnconnectedOutLayers():
        output_names.append(layer_names[i - 1])

    outputs = net.forward(output_names)

    areas = findObjects(outputs, img, conf_threshold, nms_threshold)

    return areas


def findObjects(outputs, img, conf_threshold, nms_threshold):
    shown_boxes = []
    ht, wt, ct = img.shape
    bbox = []
    classIds = []
    confs = []

    for output in outputs:
        for det in output:
            scores = det[5:]
            classId = np.argmax(scores)
            confidence = scores[classId]
            if confidence > conf_threshold:
                w, h = det[2] * wt, det[3] * ht
                x, y = det[0] * wt - w / 2, det[1] * ht - h / 2
                # if w < wt * 0.8 and h < ht * 0.8:
                bbox.append([x, y, w, h])
                classIds.append(classId)
                confs.append(float(confidence))

    nmsbox_indices = cv2.dnn.NMSBoxes(bbox, confs, conf_threshold, nms_threshold)

    for i in nmsbox_indices:
        box_add = 20
        box = bbox[i]
        x, y, w, h = int(box[0] - box_add), int(box[1] - box_add), int(box[2] + 2 * box_add), int(box[3] + 2 * box_add)
        # cv2.rectangle(img, (x, y), (int(x + w), int(y + h)), (255, 0, 255), 2)
        shown_boxes.append((x, y, w, h))

    return shown_boxes


cap = cv2.VideoCapture(0)





def process_frame(frame):
    global processing_frame
    processing_frame = True
    cv2.imwrite('./fridge-state.jpg', frame)

    analyze_pic(frame)
    processing_frame = False

    # Display the resulting frame
    cv2.imshow('frame', frame)

    time.sleep(5)


processing_frame = False
ret, frame = cap.read()
cv2.imshow('frame', frame)
while (True):
    # Capture frame-by-frame
    # frame = cv2.imread('/Users/mikhailandreev/Desktop/phone-fridge.jpg', cv2.IMREAD_COLOR)

    # process_frame(frame)
    # Our operations on the frame come here
    # gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    # cv2.imshow('frame', frame)
    key = cv2.waitKey(1)
    # if key & 0xFF == 32:
    ret, frame = cap.read()
    process_frame(frame)
    if key & 0xFF == ord('q'):
        break

    time.sleep(5)

# When everything done, release the capture
cap.release()
cv2.destroyAllWindows()

