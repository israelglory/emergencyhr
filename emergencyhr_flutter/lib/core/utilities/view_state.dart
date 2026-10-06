/// What a data screen shows. Viewmodels compute it; views switch on it.
enum ViewState { loading, error, empty, ready }

ViewState viewStateOf({
  required bool busy,
  required bool hasError,
  required bool hasData,
}) {
  if (hasError) return ViewState.error;
  if (!hasData) return busy ? ViewState.loading : ViewState.empty;
  return ViewState.ready;
}
