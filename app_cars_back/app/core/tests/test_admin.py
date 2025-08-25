"""
Tests for the Django admin modifications.
"""
from django.test import TestCase
from django.contrib.auth import get_user_model
from django.test import Client


class AdminSiteTests(TestCase):
    """Tests for the Django admin."""

    def setUp(self):
        """Set up the test case."""
        self.client = Client()
        self.admin_user = get_user_model().objects.create_superuser(
            account='admin',
            phone='1234567890',
            password='password123'
        )
        self.client.force_login(self.admin_user)
        self.user = get_user_model().objects.create_user(
            account='user',
            phone='1234567890',
            password='password123',
            name='Test User'
        )
