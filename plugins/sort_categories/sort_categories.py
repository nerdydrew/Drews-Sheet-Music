from pelican import signals
from operator import attrgetter

def sort_key(cat_tuple):
	category = cat_tuple[0]
	return str(getattr(category, 'date', category))


def set_category_order(generator):
	generator.context.get('categories', []).sort(key=sort_key)


def register():
	signals.article_generator_finalized.connect(set_category_order)