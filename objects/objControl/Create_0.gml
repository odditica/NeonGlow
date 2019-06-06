// Glow shader demo, written by @blokatt.
// 06/06/19 (MDY or DMY)

surBase = surface_create(surface_get_width(application_surface), surface_get_height(application_surface));
surPass = surface_create(surface_get_width(application_surface), surface_get_height(application_surface));

uOuterIntensity = 3.2;
uInnerIntensity = 20.0
uInnerLengthMultiplier = 2.15;
