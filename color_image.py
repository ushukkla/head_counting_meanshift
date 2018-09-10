

import cv2
from color_recognition_api import color_histogram_feature_extraction
from color_recognition_api import knn_classifier
import os
import os.path


source_image = cv2.imread('black_cat.jpg')
prediction = 'n.a.'


PATH = './training.data'

if os.path.isfile(PATH) and os.access(PATH, os.R_OK):
    
else:
    open('training.data', 'w')
    color_histogram_feature_extraction.training()
    


color_histogram_feature_extraction.color_histogram_of_test_image(source_image)
prediction = knn_classifier.main('training.data', 'test.data')
cv2.putText(
    source_image,
    'Prediction: ' + prediction,
    (15, 45),
    cv2.FONT_HERSHEY_PLAIN,
    3,
    200,
    )

cv2.imshow('color classifier', source_image)
cv2.waitKey(0)		
