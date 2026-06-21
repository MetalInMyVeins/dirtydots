/* Taken from https://github.com/djpohly/dwl/issues/466 */
#define COLOR(hex)    { ((hex >> 24) & 0xFF) / 255.0f, \
                        ((hex >> 16) & 0xFF) / 255.0f, \
                        ((hex >> 8) & 0xFF) / 255.0f, \
                        (hex & 0xFF) / 255.0f }

static const float rootcolor[]             = COLOR(0x1e180cff);
static uint32_t colors[][3]                = {
	/*               fg          bg          border    */
	[SchemeNorm] = { 0xc6c5c2ff, 0x1e180cff, 0x70695cff },
	[SchemeSel]  = { 0xc6c5c2ff, 0x9A5831ff, 0x715543ff },
	[SchemeUrg]  = { 0xc6c5c2ff, 0x715543ff, 0x9A5831ff },
};
