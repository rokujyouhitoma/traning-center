#! /usr/bin/env python
# -*- coding: utf-8 -*-

# TinySegmenter 0.1 -- Super compact Japanese tokenizer in Javascript
# (c) 2008 Taku Kudo <taku@chasen.org>
# TinySegmenter is freely distributable under the terms of a new BSD licence.
# For details, see http://lilyx.net/pages/tinysegmenter_licence.txt

# "TinySegmenter in Python" is written by Masato Hagiwara
# See http://lilyx.net/pages/tinysegmenterp.html

# This forked version is patched by Michiaki Ariga
# https://github.com/chezou/nltk/blob/master/jpbook/tinysegmenter.py

from tinysegmenter import TinySegmenter

def demo():
    segmenter = TinySegmenter()
    print(u' | '.join(segmenter.tokenize(u"私の名前は中野です")).encode('utf-8'))

if __name__ == '__main__':
    demo()
