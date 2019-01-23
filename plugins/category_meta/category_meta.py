'''Copyright 2014, 2015 Zack Weinberg

Category Metadata
-----------------

A plugin to read metadata for each category from an index file in that
category's directory.

For this plugin to work properly, your articles should not have a
Category: tag in their metadata; instead, they should be stored in
(subdirectories of) per-category directories.  Each per-category
directory must have a file named 'index.ext' at its top level, where
.ext is any extension that will be picked up by an article reader.
The metadata of that article becomes the metadata for the category,
copied over verbatim, with three special cases:

 * The category's name is set to the article's title.
 * The category's slug is set to the name of the parent directory
   of the index.ext file.
 * The _text_ of the article is stored as category.description.
'''

from pelican import signals
import os
import re

import logging
logger = logging.getLogger(__name__)


def make_category(article):
    # Reuse the article's existing category object.
    category = article.category

    category.name = article.title

    # Description from article text.
    # XXX Relative URLs in the article content may not be handled correctly.
    setattr(category, 'description', article.content)

    # Metadata, to the extent that this makes sense.
    for k, v in article.metadata.items():
        if k not in ('path', 'slug', 'category', 'name', 'title',
                     'description', 'reader'):
            setattr(category, k, v)

    logger.debug("Category: %s -> %s", category.slug, category.name)
    return category

def pretaxonomy_hook(generator):
    """This hook is invoked before the generator's .categories property is
       filled in. Each article has already been assigned a category
       object, but these objects are _not_ unique per category and so are
       not safe to tack metadata onto (as is).

       The category metadata we're looking for is represented as an
       Article object, one per directory, whose filename is 'index.ext'.
    """

    category_objects = {}
    real_articles = []

    for article in generator.articles:
        dirname, fname = os.path.split(article.source_path)
        fname, _ = os.path.splitext(fname)
        if fname == 'index':
            category_objects[dirname] = \
                make_category(article)
        else:
            real_articles.append(article)

    category_assignment = \
        re.compile("^(" +
                   "|".join(re.escape(prefix)
                            for prefix in category_objects.keys()) +
                   ")/")

    for article in real_articles:
        m = category_assignment.match(article.source_path)
        if not m or m.group(1) not in category_objects:
            logger.error("No category assignment for %s (%s)",
                         article, article.source_path)
            continue

        article.category = category_objects[m.group(1)]

    generator.articles = real_articles

def register():
    signals.article_generator_pretaxonomy.connect(pretaxonomy_hook)
