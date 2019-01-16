#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

SITENAME = u"Drew\u2019s Sheet Music"
SITEURL = ''

PATH = 'content'
TIMEZONE = 'America/New_York'
DEFAULT_LANG = u'en'

DEFAULT_PAGINATION = False
RELATIVE_URLS = False

FEED_ALL_ATOM = 'feeds/all.atom.xml'
CATEGORY_FEED_ATOM = 'feeds/{slug}.atom.xml'

PLUGIN_PATHS = ['plugins']
PLUGINS = ['more_categories']

PATH_METADATA = '(?P<category>.*)/.*'

# URLs
ARTICLE_URL = '{category}/{slug}'
ARTICLE_SAVE_AS = '%s/index.html' % ARTICLE_URL

CATEGORY_URL = '{slug}'
CATEGORY_SAVE_AS = '%s/index.html' % CATEGORY_URL