import time

import numpy as np
import requests
import cv2

import io,zlib
def encode_ndarray(np_array):    #utility function
    bytestream = io.BytesIO()
    np.save(bytestream, np_array)
    uncompressed = bytestream.getvalue()
    compressed = zlib.compress(uncompressed,level=1)   #level can be 0-9, 0 means no compression
    return compressed

def predict_product(img):
    try:
        r = requests.post("https://zerowastecustom-prediction.cognitiveservices.azure.com/customvision/v3.0/Prediction/9d829228-446c-43da-9750-fbcfb6bdaabf/classify/iterations/Iteration1/image", data=cv2.imencode('.jpg', img)[1].tostring(), headers={"Prediction-Key": "35163ed9df2045a98dbdcd12200b9558", 'Content-type': 'application/octet-stream'})
        res = r.json()
        predictions = res["predictions"]
        print(predictions[0]["tagName"])
        return predictions[0]
    except Exception:
        return None

def analyze_pic(img):


cap = cv2.VideoCapture(0)

while(True):
    # Capture frame-by-frame
    ret, frame = cap.read()

    # Our operations on the frame come here
    # gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    results = analyze_pic(frame)
    print(results)

    # Display the resulting frame
    cv2.imshow('frame',frame)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break



# When everything done, release the capture
cap.release()
cv2.destroyAllWindows()