import sys
from collections import deque
import string
# Author: Sean Kelly
# Date: 9/10/20
# Filename: word_path.py
#
# Description: Implementation of a search algorithm to find a
# shortest path of words from a given start word to a given
# goal word. At each step, any single letter in the word
# can be changed to any other letter, provided
# that the resulting word is also in the dictionary.
# 
# A dictionary of English words a text file, a start word,
# and a goal word are passed as command line arguments.
# 
# Usage: python3 word_path.py dictionaryFile startWord endWord

def read_file(filename):
    """Read in each word from a dictionary where each
    word is listed on a single line."""
    print("Reading dictionary: " +filename)
    word_dict = set()

    dictionary = open(filename)

    # Read each word from the dictionary
    for word in dictionary:
        # Remove the trailing newline character
        word = word.rstrip('\n')

        # Convert to lowercase
        word = word.lower()

        word_dict.add(word)

    dictionary.close()

    return word_dict


class Node:
    def __init__(self,state,parent):
        self.state = state
        self.parent = parent

    # Nodes with the same state are seen as equal and hash to the same value
    def __eq__(self, other_node):
        return isinstance(other_node, Node) and self.state == other_node.state
    def __hash__(self):
        return hash(self.state)

def find_path(startWord, goalWord, word_dict):

    initial = Node(startWord, None)
    frontier = deque()
    frontier.append(initial)
    explored = set()

    if(startWord == goalWord):
        return [startWord]

    while(frontier):
        # chooses the shallowest node in frontier.
        current = frontier.popleft()
        explored.add(current.state)

        for i in range(len(current.state)):
            for letter in string.ascii_lowercase:
                posWord = current.state[:i]+letter+current.state[i+1:]
                if(posWord in word_dict):
                    child = Node(posWord,current)
                    if(child.state not in explored and child not in frontier):
                        if (child.state == goalWord):
                            solution = []
                            solution.append(goalWord)
                            prev = current
                            while(prev is not None):
                                solution.append(prev.state)
                                prev = prev.parent
                            solution.reverse()
                            return solution
                        frontier.append(child)
    return None

def main():
    if len(sys.argv) != 4:
        print('Usage: python3 words.py dictionaryFile startWord goalWord')
    else:
        dictionaryFile = sys.argv[1]
        startWord = sys.argv[2]
        goalWord = sys.argv[3]

        word_dict = set()
        word_dict = read_file(dictionaryFile)

        if startWord not in word_dict:
            print("Starting word is not in the given dictionary.")
        else:
            print('-- Solution for: ' + startWord + ' to ' + goalWord + ' --')

            solution = find_path(startWord, goalWord, word_dict)

            if(solution is None):
                print("None exists!")
            else:
                for word in solution:
                    print(word)

if __name__ == '__main__':
    main()
