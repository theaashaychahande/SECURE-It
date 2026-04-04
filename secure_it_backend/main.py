from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import xgboost as xgb
import os

app = FastAPI(title="SECURE-it Backend API", description="AI scam detection inference service")

# Load model (globally so it mounts once on startup)
model_path = os.path.join(os.path.dirname(__file__), "xgboost_fraud_model.json")
booster = None

@app.on_event("startup")
async def load_model():
    global booster
    if os.path.exists(model_path):
        booster = xgb.Booster()
        booster.load_model(model_path)
        print("XGBoost model loaded successfully.")
    else:
        print(f"Warning: Model file not found at {model_path}. Predictions will fail until trained model is supplied.")

# Define the expected JSON payload from your Flutter app
class TransactionData(BaseModel):
    amount: float
    is_new_payee: int
    time_of_day_hour: int
    device_trust_score: float

@app.get("/")
def read_root():
    return {"status": "online", "message": "SECURE-it Backend is running."}

@app.post("/evaluate-risk")
def evaluate_risk(data: TransactionData):
    if booster is None:
        raise HTTPException(status_code=503, detail="Model is currently unavailable. Ensure training is completed.")
    
    # Create DMatrix for XGBoost prediction
    # In a real app, ensure the feature order strictly matches the training data format
    features = [[
        data.amount,
        data.is_new_payee,
        data.time_of_day_hour,
        data.device_trust_score
    ]]
    dmatrix = xgb.DMatrix(features)
    
    prediction = booster.predict(dmatrix)
    
    # Prediction returns an array of probabilities, we get the first one
    risk_probability = float(prediction[0]) * 100 
    
    return {
        "risk_score": round(risk_probability, 2),
        "is_high_risk": risk_probability > 70.0
    }
