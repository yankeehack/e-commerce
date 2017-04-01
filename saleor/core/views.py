import logging

from django.template.response import TemplateResponse

from ..product.utils import products_with_availability, products_for_homepage
from ..core.tasks.tasks import cao

logger = logging.getLogger(__name__)


def home(request):
    products = products_for_homepage()[:8]
    products = products_with_availability(
        products, discounts=request.discounts, local_currency=request.currency)
    cao.delay('This is just a test!')
    logger.info('calling here!')
    return TemplateResponse(
        request, 'home.html',
        {'products': products, 'parent': None})
