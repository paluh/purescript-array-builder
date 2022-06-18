export unsafeSnocArray = function (suffix) {
  return function (arr) {
    arr.push(...suffix);
    return arr;
  };
};

export unsafeCons = function (a) {
  return function (arr) {
    arr.unshift(a);
    return arr;
  };
};

export unsafeConsArray = function (prefix) {
  return function (arr) {
    arr.unshift(...prefix);
    return arr;
  };
};
export unsafeSnoc = function (a) {
  return function (arr) {
    arr.push(a);
    return arr;
  };
};
