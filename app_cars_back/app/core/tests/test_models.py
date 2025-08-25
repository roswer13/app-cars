"""
Tests for models.
"""
from django.test import TestCase
from django.contrib.auth import get_user_model


class UserModelTests(TestCase):
    """Test the User model."""

    def test_create_user_with_email_successful(self):
        """Test creating a user with an email is successful."""
        account = "testuser"
        phone = "1234567890"
        password = "testpassword123"
        user = get_user_model().objects.create_user(
            account=account,
            phone=phone,
            password=password,
        )
        self.assertEqual(user.account, account)
        self.assertEqual(user.phone, phone)

    def test_new_user_without_account_raises_error(self):
        """Test creating user without an account raises error"""
        with self.assertRaises(ValueError):
            get_user_model().objects.create_user(
                account='', phone='1234567890', password='test123'
            )

    def test_create_superuser(self):
        """Test creating a superuser"""
        user = get_user_model().objects.create_superuser(
            account='testuser',
            phone='1234567890',
            password='test123'
        )
        self.assertTrue(user.is_superuser)
        self.assertTrue(user.is_staff)
