// ignore_for_file: unnecessary_new, prefer_conditional_assignment, prefer_collection_literals, non_constant_identifier_names, file_names

class AppContext {
  static AppContext? INSTANCE;
  static Map<String,Object> context = new Map();

  static void createInstance(){
    if (INSTANCE == null) {
      INSTANCE = new AppContext();
    }
  }

  static AppContext getInstance(){
    if (INSTANCE == null) {
      createInstance();
    }
    return INSTANCE!;
  }

  set(String key, Object value){
    context.addAll({key: value});
  }

  get(String key){
    return context[key];
  }
  void initialize(){
    context.clear();
  }
}