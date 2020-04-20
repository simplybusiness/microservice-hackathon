import doctest

def thing_to_be_tested():
    """Must be able to tell the meaning of life:
    >>> thing_to_be_tested()
    42
    """
    return 6 * 9

if __name__ == '__main__':
    doctest.testmod()
