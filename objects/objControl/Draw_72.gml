if (!surface_exists(surBase)) {
	surBase = surface_create(surface_get_width(application_surface), surface_get_height(application_surface));
}

if (!surface_exists(surPass)) {
	surPass = surface_create(surface_get_width(application_surface), surface_get_height(application_surface));
}
