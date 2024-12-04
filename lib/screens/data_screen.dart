import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ac_fit/store/app_store.dart';
import 'package:ac_fit/models/data_state.dart';
import 'package:ac_fit/middlewares/middleware.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Data Screen")),
      body: StoreConnector<AppState, DataState>(
        converter: (store) => store.state.dataState,
        builder: (context, dataState) {
          if (dataState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (dataState.error != null) {
            return Center(child: Text("Error: ${dataState.error}"));
          }
          return ListView.builder(
            itemCount: dataState.data.length,
            itemBuilder: (context, index) {
              final item = dataState.data[index];
              return ListTile(
                title: Text(item["title"]),
                subtitle: Text(item["body"]),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            StoreProvider.of<AppState>(context).dispatch(fetchData()),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
