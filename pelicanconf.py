#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

SITENAME = u"Drew\u2019s Sheet Music"
SITEURL = '/sheetmusic'

PATH = 'content'
TIMEZONE = 'America/New_York'
DEFAULT_LANG = u'en'

THEME = 'theme'
THEME_STATIC_DIR = 'static'
TITLE_SEPARATOR = '&ndash;'

DEFAULT_PAGINATION = False

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

AUTHOR_SAVE_AS = False
AUTHORS_SAVE_AS = False
TAG_SAVE_AS = False
TAGS_SAVE_AS = False
ARCHIVES_SAVE_AS = False
CATEGORIES_SAVE_AS = False