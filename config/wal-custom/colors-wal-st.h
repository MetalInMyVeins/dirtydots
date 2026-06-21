const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#1e180c", /* black   */
  [1] = "#715543", /* red     */
  [2] = "#9A5831", /* green   */
  [3] = "#B3562A", /* yellow  */
  [4] = "#9D6B47", /* blue    */
  [5] = "#DEA862", /* magenta */
  [6] = "#DBAD67", /* cyan    */
  [7] = "#c6c5c2", /* white   */

  /* 8 bright colors */
  [8]  = "#70695c",  /* black   */
  [9]  = "#715543",  /* red     */
  [10] = "#9A5831", /* green   */
  [11] = "#B3562A", /* yellow  */
  [12] = "#9D6B47", /* blue    */
  [13] = "#DEA862", /* magenta */
  [14] = "#DBAD67", /* cyan    */
  [15] = "#c6c5c2", /* white   */

  /* special colors */
  [256] = "#1e180c", /* background */
  [257] = "#c6c5c2", /* foreground */
  [258] = "#c6c5c2",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
