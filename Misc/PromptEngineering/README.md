# Prompt Engineering: How to Talk to the AIs
https://www.linkedin.com/learning/prompt-engineering-how-to-talk-to-the-ais/talking-to-the-ais

## GenAI & Prompts
- <span style="background-color: yellow">Generative AI (GenAI)</span> refers to models that can generate content from a natural language prompt
    - Text prompt to text output
    - Text prompt to image output
    - Text prompt to actions
- A big breakthrough in these models is their zero-shot learning capability
    - Can learn from new information on the fly
    - Don't need to be retrained
- A <span style="background-color: yellow">prompt</span> is typically the text input that tells the model what to do
- Basic prompts can include
    - Instructions
    - Questions
    - Input data
    - Examples

## Prompt Engineering
- Good prompts help to fully utilize LLM potential while minimizing their limitations
- Prompt engineering requires knowledge for both the domain and specific AI model
- One application of prompt engineering is prompt templates
    - Allows you to programmatically modify them based on some database or context 
    - Python example:
        ```py
        for user, blurb in students.items():
            prompt = f'''
            Given the following information about {user}, write a 4 paragraph college
            essay: {blurb}
            '''

            callGPT(prompt)
        ```
- Model responses are stochastic
    - Random at every run
    - Can be adjusted via temperature
- Ideally we want prompts to consistently result in the most factually-correct response
- One method is with <span style="background-color: yellow">chain of thought (CoT)</span>
    - Forces model to examine its own response
    - Can help to catch errors or mistakes
- Example CoT prompt:
    ```
    What European soccer team won the Champions League the year Barcelona hosted the Olympic games?
    Use this format:
    Q: <repeat_question>
    A: Let's think step by step. <give_reasoning> Therefore, the answer is <final_answer>.
    ```
- Another method that helps prevent hallucination is to ask it to cite sources
    - The model could still come up with fake sources
    - However, this allows user to verify the sources and ensure info is correct
- The `<|endofprompt|>` is a special token for GPT models that helps separate prompt instructions and example data
- Example:
    ```
    Write a scary short story. <|endofprompt|> It was a beautiful day.
    ```

## Tips and Tricks
- Using forceful language (all caps, exclamation marks), can sometimes yield better results
- Give instructions before examples
- Modern AI models can work with different languages as well
- Use affordances to help guide model behavior
    - Structure: outline a template for the model to format its response
    - Context: saying stuff like "You are a ..." which can set the tone
    - Instruction: clearly state the task for the model to complete
