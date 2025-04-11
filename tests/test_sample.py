from sample_module.sample_code import add

def test_add():
    assert add(2, 3) == 5

def test_add_negative():
    assert add(-2, -3) == -5

def test_add_mixed():
    assert add(-1, 1) == 0

def test_add_zeros():
    assert add(0, 0) == 0

def test_add_large():
    assert add(1_000_000, 2_000_000) == 3_000_000
