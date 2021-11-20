# %matplotlib inline
import pandas as pd
import os,scipy, shutil,math,cv2
import numpy as np
import matplotlib.pyplot as plt
import random as rn


from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from tqdm import tqdm
from IPython.display import SVG

import tensorflow as tf
from keras.utils.np_utils import to_categorical
from keras import layers
from keras.preprocessing.image import save_img
from keras.utils.vis_utils import model_to_dot
from keras.applications.vgg16 import VGG16,preprocess_input
from keras.models import Sequential,Input,Model
from keras.layers import Dense,Flatten,Dropout,Concatenate,GlobalAveragePooling2D,Lambda,ZeroPadding2D
from keras.layers import SeparableConv2D,BatchNormalization,MaxPooling2D,Conv2D
from keras.preprocessing.image import ImageDataGenerator
from keras.utils.vis_utils import plot_model
from keras.callbacks import ModelCheckpoint,EarlyStopping,TensorBoard,CSVLogger,ReduceLROnPlateau,LearningRateScheduler


def show_final_history(history):
    fig, ax = plt.subplots(1, 2, figsize=(15,5))
    ax[0].set_title('loss')
    ax[0].plot(history.epoch, history.history["loss"], label="Train loss")
    ax[0].plot(history.epoch, history.history["val_loss"], label="Validation loss")
    ax[1].set_title('acc')
    ax[1].plot(history.epoch, history.history["acc"], label="Train acc")
    ax[1].plot(history.epoch, history.history["val_acc"], label="Validation acc")
    ax[0].legend()
    ax[1].legend()


def label_assignment(img, label):
    return label


def training_data(label, data_dir):
    for img in tqdm(os.listdir(data_dir)):
        label = label_assignment(img, label)
        path = os.path.join(data_dir, img)
        img = cv2.imread(path, cv2.IMREAD_COLOR)
        img = cv2.resize(img, (imgsize, imgsize))

        X.append(np.array(img))
        Z.append(str(label))

beans = '../input/repository/abhinavsagar-grocery-c457bd9/BEANS'
cake = '../input/repository/abhinavsagar-grocery-c457bd9/CAKE'
candy = '../input/repository/abhinavsagar-grocery-c457bd9/CANDY'
cereal = '../input/repository/abhinavsagar-grocery-c457bd9/CEREAL'
chips = '../input/repository/abhinavsagar-grocery-c457bd9/CHIPS'
chocolate = '../input/repository/abhinavsagar-grocery-c457bd9/CHOCOLATE'
coffee = '../input/repository/abhinavsagar-grocery-c457bd9/COFFEE'
corn = '../input/repository/abhinavsagar-grocery-c457bd9/CORN'
fish = '../input/repository/abhinavsagar-grocery-c457bd9/FISH'
flour = '../input/repository/abhinavsagar-grocery-c457bd9/FLOUR'
honey = '../input/repository/abhinavsagar-grocery-c457bd9/HONEY'
jam = '../input/repository/abhinavsagar-grocery-c457bd9/JAM'
juice = '../input/repository/abhinavsagar-grocery-c457bd9/JUICE'
milk = '../input/repository/abhinavsagar-grocery-c457bd9/MILK'
nuts = '../input/repository/abhinavsagar-grocery-c457bd9/NUTS'
oil = '../input/repository/abhinavsagar-grocery-c457bd9/OIL'
pasta = '../input/repository/abhinavsagar-grocery-c457bd9/PASTA'
rice = '../input/repository/abhinavsagar-grocery-c457bd9/RICE'
soda = '../input/repository/abhinavsagar-grocery-c457bd9/SODA'
spices = '../input/repository/abhinavsagar-grocery-c457bd9/SPICES'
sugar = '../input/repository/abhinavsagar-grocery-c457bd9/SUGAR'
tea = '../input/repository/abhinavsagar-grocery-c457bd9/TEA'
tomato_sauce = '../input/repository/abhinavsagar-grocery-c457bd9/TOMATO_SAUCE'
vinegar = '../input/repository/abhinavsagar-grocery-c457bd9/VINEGAR'
water = '../input/repository/abhinavsagar-grocery-c457bd9/WATER'

X = []
Z = []
imgsize = 150

training_data('beans',beans)
training_data('cake',cake)
training_data('candy',candy)
training_data('cereal',cereal)
training_data('chips',chips)
training_data('chocolate',chocolate)
training_data('coffee',coffee)
training_data('corn',corn)
training_data('fish',fish)
training_data('flour',flour)
training_data('honey',honey)
training_data('jam',jam)
training_data('juice',juice)
training_data('milk',milk)
training_data('nuts',nuts)
training_data('oil',oil)
training_data('psata',pasta)
training_data('rice',rice)
training_data('soda',soda)
training_data('spices',spices)
training_data('sugar',sugar)
training_data('tea',tea)
training_data('tomato sauce',tomato_sauce)
training_data('vinegar',vinegar)
training_data('water',water)


label_encoder= LabelEncoder()
Y = label_encoder.fit_transform(Z)
Y = to_categorical(Y,25)
X = np.array(X)
X=X/255

x_train,x_test,y_train,y_test = train_test_split(X,Y,test_size=0.2,random_state=42)

augs_gen = ImageDataGenerator(
        featurewise_center=False,
        samplewise_center=False,
        featurewise_std_normalization=False,
        samplewise_std_normalization=False,
        zca_whitening=False,
        rotation_range=10,
        zoom_range = 0.1,
        width_shift_range=0.2,
        height_shift_range=0.2,
        horizontal_flip=True,
        vertical_flip=False)

augs_gen.fit(x_train)

fig, ax = plt.subplots(5, 5)
fig.set_size_inches(15, 15)
for i in range(5):
    for j in range(5):
        l = rn.randint(0, len(Z))
        ax[i, j].imshow(X[l])
        ax[i, j].set_title('Grocery: ' + Z[l])

plt.tight_layout()

base_model = VGG16(include_top=False,
                   input_shape=(imgsize, imgsize, 3),
                   weights='imagenet')

for layer in base_model.layers:
    layer.trainable = False

for layer in base_model.layers:
    print(layer, layer.trainable)

model = Sequential()
model.add(base_model)
model.add(GlobalAveragePooling2D())
model.add(Dropout(0.3))
model.add(Dense(25, activation='softmax'))
model.summary()

SVG(model_to_dot(model).create(prog='dot', format='svg'))
plot_model(model, to_file='model_plot.png', show_shapes=True, show_layer_names=True)


checkpoint = ModelCheckpoint(
    './base.model',
    monitor='val_acc',
    verbose=1,
    save_best_only=True,
    mode='max',
    save_weights_only=False,
    period=1
)
earlystop = EarlyStopping(
    monitor='val_loss',
    min_delta=0.001,
    patience=30,
    verbose=1,
    mode='auto'
)
tensorboard = TensorBoard(
    log_dir = './logs',
    histogram_freq=0,
    batch_size=16,
    write_graph=True,
    write_grads=True,
    write_images=False,
)

csvlogger = CSVLogger(
    filename= "training_csv.log",
    separator = ",",
    append = False
)

reduce = ReduceLROnPlateau(
    monitor='val_loss',
    factor=0.1,
    patience=3,
    verbose=1,
    mode='auto'
)

callbacks = [checkpoint,tensorboard,csvlogger,reduce]



opt = tf.keras.optimizers.SGD(lr=1e-4,momentum=0.99)
opt1 = tf.keras.optimizers.Adam(lr=1e-3)

model.compile(
    loss='categorical_crossentropy',
    optimizer=opt1,
    metrics=['accuracy']
)

history = model.fit_generator(
    augs_gen.flow(x_train,y_train,batch_size=128),
    validation_data  = (x_test,y_test),
    validation_steps = 100,
    steps_per_epoch  = 100,
    epochs = 50,
    verbose = 1,
    callbacks=callbacks
)

show_final_history(history)
model.load_weights('./base.model')

model_json = model.to_json()
with open("model.json", "w") as json_file:
    json_file.write(model_json)

model.save("model.h5")
print("Weights Saved")