from django import template

register = template.Library()

@register.filter
def get_note_color_class(value):
    """Retourne une classe CSS en fonction de la valeur d'une note ou moyenne."""
    if value is None:
        return "note-none"
    try:
        val = float(value)
        if val < 8:
            return "note-bad"
        elif val < 12:
            return "note-ok"
        else:
            return "note-good"
    except (ValueError, TypeError):
        return "note-none"