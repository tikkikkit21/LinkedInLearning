"""My Solution"""
import pickle

def save_dictionary(dictionary: dict, output: str):
    pickle.dump(dictionary, open(output, "wb"))

def load_dictionary(source: str):
    return pickle.load(open(source, "rb"))

"""Instructor's Solution"""
def save_dict(dict_to_save, file_path):
    with open(file_path, 'wb') as file:
        pickle.dump(dict_to_save, file)

def load_dict(file_path):
    with open(file_path, 'rb') as file:
        return pickle.load(file)


"""Thoughts:
Pretty much the exact same logic. First time I've seen 'with/as' syntax 
"""
