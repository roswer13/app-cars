"""
User model.
"""
from django.db import models
from django.contrib.auth.models import (
    AbstractBaseUser,
    BaseUserManager,
    PermissionsMixin,
)
from django.utils.translation import gettext_lazy as _


class UserManager(BaseUserManager):
    """ Manager for users. """

    def create_user(self, account, phone, password=None, **extra_fields):
        """Create, save and return a new user."""
        if not account or not phone:
            raise ValueError(
                'Users must have an account name and phone number.'
                )

        user = self.model(account=account, phone=phone, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, account, phone, password=None):
        """Create and return a superuser with given account, phone
        and password."""
        user = self.create_user(account, phone, password)
        user.is_staff = True
        user.is_superuser = True
        user.save(using=self._db)
        return user


class User(AbstractBaseUser, PermissionsMixin):
    """User in the system."""
    account = models.CharField(
        verbose_name=_('Account'), max_length=128, unique=True,
        help_text=_('Account name of the user.')
    )
    phone = models.CharField(
        verbose_name=_('Phone'), max_length=15,
        help_text=_('Phone number of the user.')
    )
    name = models.CharField(
        verbose_name=_('User name'), max_length=128,
        help_text=_('Name of the user.')
    )
    is_staff = models.BooleanField(
        verbose_name=_('Staff'), default=False,
        help_text=_('Is a user of the internal equipment.'),
    )
    is_active = models.BooleanField(
        verbose_name=_('Active'), default=True,
        help_text=_('Indicates if the user is active.'),
    )

    objects = UserManager()

    USERNAME_FIELD = 'account'

    def __str__(self):
        """Return string representation of user."""
        return self.account
