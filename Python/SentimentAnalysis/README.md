# AI Sentiment Analysis with PyTorch and Hugging Face Transformers
https://www.linkedin.com/learning/ai-sentiment-analysis-with-pytorch-and-hugging-face-transformers

## Sentiment Analysis
- <span style="background-color: yellow">Sentiment analysis</span> is an NLP task that classifies the tone of a piece of text
    - Positive, negative, or neutral
    - Advanced models can classify more complex emotions like joy, sadness, anger, etc.
- Applications
    - Customer feedback analysis
    - Social media marketing
    - Public opinion analysis
    - Financial market analysis

## DistilBERT
- <span style="background-color: yellow">BERT</span> stands for "bidirectional encoder representations from transformers"
- Processes text from both directions
    - Helps it to better understand context of words
- <span style="background-color: yellow">DistilBERT</span> is a distilled version of BERT
    - BERT is the main "teacher" model
    - DistilBirt is the "student" model
- Results in a much more compact model that mimics the strength of original BERT

## Evaluation Metrics
- Metrics can measure how well a model performs
- Helps to compare between different models
- Provides insights into areas of improvement
- Common metrics
    - Accuracy: overall correctness
    - Precision: correct positive predictions out of all positive predictions made
    - Recall: correct positive predictions out of all actual positives
    - F1: balances between precision and recall

## Edge Cases
- This simple model may struggle with edge cases
    - Sarcasm
    - Mixed emotions
- We can use advanced techniques to help account for them
    - Fine-tuning with specific data
    - Preprocessing tricky inputs
    - Combining with other techniques
- Reminders
    - Test model thoroughly on diverse data
    - Understand limitations since no model is perfect

## Advanced NLP Applications
- Text summarization
    - Generates concise summaries of long documents
    - Useful for news articles and research papers
- Machine translation
    - Translates from 1 language to another
    - Works together with other tools like Google Translate
- Question answering
    - Answers questions based on body of text
    - Customer support, education, search engines
