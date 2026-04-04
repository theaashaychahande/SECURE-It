import pandas as pd
import xgboost as xgb
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
import os

# Define paths
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DATASET_PATH = os.path.join(BASE_DIR, "dataset", "transactions.csv")
# We save the model directly into the backend folder so it's ready for deployment
MODEL_OUTPUT_PATH = os.path.join(BASE_DIR, "..", "secure_it_backend", "xgboost_fraud_model.json")

def simulate_dummy_data():
    """Generates dummy data if CSV doesn't exist yet for testing."""
    import numpy as np
    np.random.seed(42)
    # 1000 simulated transactions
    data = {
        "amount": np.random.uniform(10, 50000, 1000),
        "is_new_payee": np.random.choice([0, 1], 1000, p=[0.8, 0.2]),
        "time_of_day_hour": np.random.randint(0, 24, 1000),
        "device_trust_score": np.random.uniform(0, 100, 1000),
        "is_fraud": np.random.choice([0, 1], 1000, p=[0.9, 0.1]) # 10% fraud rate for testing
    }
    df = pd.DataFrame(data)
    os.makedirs(os.path.dirname(DATASET_PATH), exist_ok=True)
    df.to_csv(DATASET_PATH, index=False)
    print(f"Dummy dataset generated at {DATASET_PATH}")
    return df

def train():
    if not os.path.exists(DATASET_PATH):
        print(f"Warning: Dataset not found at {DATASET_PATH}. Generating dummy data...")
        df = simulate_dummy_data()
    else:
        print(f"Loading data from {DATASET_PATH}...")
        df = pd.read_csv(DATASET_PATH)

    # Note: Column names MUST match the features the FastAPI backend utilizes
    features = ['amount', 'is_new_payee', 'time_of_day_hour', 'device_trust_score']
    target = 'is_fraud'

    X = df[features]
    y = df[target]

    # Split into testing and training sets
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    print("Training XGBoost Classifier...")
    model = xgb.XGBClassifier(
        n_estimators=100,
        max_depth=4,
        learning_rate=0.1,
        use_label_encoder=False,
        eval_metric='logloss'
    )
    
    model.fit(X_train, y_train)

    print("Evaluating Model...")
    predictions = model.predict(X_test)
    accuracy = accuracy_score(y_test, predictions)
    print(f"Model Accuracy: {accuracy * 100:.2f}%")

    print(f"Saving model to {MODEL_OUTPUT_PATH}...")
    # XGBoost recommends JSON format for model portability
    os.makedirs(os.path.dirname(MODEL_OUTPUT_PATH), exist_ok=True)
    model.save_model(MODEL_OUTPUT_PATH)
    print("Training completed successfully!")

if __name__ == "__main__":
    train()
