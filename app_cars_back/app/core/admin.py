"""
Django admin customization.
"""
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin
from django.utils.translation import gettext_lazy as _

from core.models import User, Vehicule


@admin.register(User)
class UserAdmin(BaseUserAdmin):
    """Define the admin pages for users."""
    ordering = ['id']
    list_display = ['account', 'phone', 'name']
    fieldsets = (
        (None, {'fields': ('account', 'phone', 'password')}),
        (
            _('Permissions'),
            {'fields': ('is_active', 'is_staff', 'is_superuser')}
        ),
        (_('Important dates'), {'fields': ('last_login',)})
    )
    readonly_fields = ['last_login']
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': (
                'account', 'phone', 'password1', 'password2', 'name',
                'is_active', 'is_staff', 'is_superuser'
            )
        }),
    )


@admin.register(Vehicule)
class VehiculeAdmin(admin.ModelAdmin):
    """Define the admin pages for vehicles."""
    list_display = ['plate', 'label', 'status_color', 'last_update']
    search_fields = ['plate', 'label']
    readonly_fields = ['last_update']
