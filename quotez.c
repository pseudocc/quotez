#include <stdio.h>
#include <stdlib.h>
#include <json-c/json.h>

#ifndef DATADIR
#define DATADIR ""
#endif

#define JSONPATH (DATADIR "/quotes.json")

void print_quote(array_list* quotes, size_t i) {
  size_t n_quotes = array_list_length(quotes);
  json_object* item = array_list_get_idx(quotes, i % n_quotes);
  json_object* tobj = json_object_object_get(item, "text");

  printf("%s\n", json_object_get_string(tobj));
}

int main(int argc, const char* args[]) {
  json_object* root = json_object_from_file(JSONPATH);
  if (root == NULL) {
    fprintf(stderr, "Failed to load quotes from json file: %s\n", JSONPATH);
    return 1;
  }
  array_list* quotes = json_object_get_array(root);

  if (argc > 1) {
    int index;
    for (int i = 1; i < argc; i++)
      print_quote(quotes, atoi(args[i]));
    return 0;
  }

  size_t n_quotes = array_list_length(quotes);
  for (size_t i = 0; i < n_quotes; i++)
    print_quote(quotes, i);

  return 0;
}
