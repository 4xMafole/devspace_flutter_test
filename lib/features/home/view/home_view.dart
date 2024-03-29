import 'package:devspace_test/features/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is ItemErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red.shade600,
              content: Text(state.message),
            ),
          );
        }

        if (state is ItemAddLoadingState || state is ItemRemoveLoadingState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.blue.shade600,
              content: Row(
                children: const [
                  SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text('loading'),
                ],
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        final items = (state is ItemAddState || state is ItemRemoveState)
            ? (state is ItemAddState)
                ? state.items
                : (state as ItemRemoveState).items
            : <String>[];
        final gridHeight =
            (context.read<HomeBloc>().items.length / 2).ceil() * 100.0;

        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            var imageHeight = constraints.maxHeight - gridHeight;
            imageHeight = imageHeight.clamp(100.0, constraints.maxHeight);
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    child: Image.asset(
                      'assets/app_logo.png',
                      height: imageHeight,
                    ),
                  ),
                  if (items.isNotEmpty) ...[
                    GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(child: Text(items[index])),
                        );
                      },
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }
}
