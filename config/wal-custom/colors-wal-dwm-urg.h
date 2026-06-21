static const char norm_fg[] = "#c6c5c2";
static const char norm_bg[] = "#1e180c";
static const char norm_border[] = "#70695c";

static const char sel_fg[] = "#c6c5c2";
static const char sel_bg[] = "#9A5831";
static const char sel_border[] = "#c6c5c2";

static const char urg_fg[] = "#c6c5c2";
static const char urg_bg[] = "#715543";
static const char urg_border[] = "#715543";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
