from pelican import signals
from operator import attrgetter


def set_category_order(generator):
	generator.context.get('categories', []).sort(key=lambda t: attrgetter('date'), reverse=True)


def register():
	signals.article_generator_finalized.connect(set_category_order)