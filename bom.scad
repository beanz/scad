module vitamin(n) {
  if (bom > 1) {
    echo(str("VTM: ", n));
  }
}

module stl(n) {
  if (bom > 0) {
    echo(str("STL: ", n));
  }
}

module begin(n) {
  if (bom > 0) {
    echo(str(n, "{"));
  }
}

module end(n) {
  if (bom > 0) {
    echo(str("}", n));
  }
}

