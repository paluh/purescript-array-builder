export function unsafeSnocArray(suffix) {
  return function (arr) {
    arr.push(...suffix);
    return arr;
  };
};

export function unsafeCons(a) {
  return function (arr) {
    arr.unshift(a);
    return arr;
  };
};

export function unsafeConsArray(prefix) {
  return function (arr) {
    arr.unshift(...prefix);
    return arr;
  };
};
export function unsafeSnoc(a) {
  return function (arr) {
    arr.push(a);
    return arr;
  };
};
