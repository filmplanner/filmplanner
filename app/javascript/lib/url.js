var url = (path, params) => {
  const esc = encodeURIComponent;
  const query = Object.keys(params).map(k => params[k] !== undefined ? esc(k) + '=' + esc(params[k]) : null).filter(k => k !== null).join('&');

  return path + '?' + query
}

export { url }