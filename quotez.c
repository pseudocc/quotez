#include <stdio.h>
#include <stdlib.h>
#include <json-c/json.h>

int main(void) {
  json_object* root = json_object_from_file("quotes.json");;
  array_list* quotes = json_object_get_array(root);

  size_t n_quotes = array_list_length(quotes);
  for (size_t i = 0; i < n_quotes; i++) {
    json_object* item = array_list_get_idx(quotes, i);
    json_object* tobj = json_object_object_get(item, "text");

    printf("%s\n", json_object_get_string(tobj));
  }
}