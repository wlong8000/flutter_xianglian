String getText(String text, {String defaultString = ''}) {
  return text == null || text == 'null' ? defaultString : text;
}
