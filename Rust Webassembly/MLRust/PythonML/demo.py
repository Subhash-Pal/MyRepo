from sklearn.neighbors import KNeighborsClassifier as KNN
import numpy as np
from sklearn.model_selection import train_test_split

# Load dataset
from sklearn.datasets import load_iris
iris = load_iris()

X = iris.data
y = iris.target

# Split dataset into train and test
X_train, X_test, y_train, y_test = 	train_test_split(X, y, test_size=0.3,
					random_state=2018)

# import KNeighborsClassifier model
knn = KNN(n_neighbors=3)

# train model
knn.fit(X_train, y_train)
import pickle

dbfile = open('MLPickle', 'wb')
# Save the trained model as a pickle string.
pickle.dump(knn,dbfile )
dbfile.close()
  
saved_model=  open('MLPickle', 'rb')
# Load the pickled model
knn_from_pickle = pickle.load(saved_model)
  
# Use the loaded pickled model to make predictions
print(knn_from_pickle.predict(X_test))