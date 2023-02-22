// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../enum/result_state.dart';
import '../provider/restaurant_detail_provider.dart';

class CardReview extends StatelessWidget {
  final RestaurantDetailProvider provider;
  final String restaurantId;

  final _nameController = TextEditingController();
  final _reviewController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  CardReview({
    super.key,
    required this.provider,
    required this.restaurantId,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      insetPadding: const EdgeInsets.all(16),
      title: const Text(
        'Tambah Review',
      )
          .animate()
          .fade(
            duration: 850.ms,
          )
          .slideY(
            begin: -0.3,
            duration: 1200.ms,
            curve: Curves.fastOutSlowIn,
          ),
      titleTextStyle: Theme.of(context).textTheme.headline6,
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Nama',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'Nama tidak boleh kosong!';
                    }
                    return null;
                  },
                )
                    .animate()
                    .fade(
                      duration: 850.ms,
                    )
                    .slideX(
                      begin: -0.3,
                      duration: 1200.ms,
                      curve: Curves.fastOutSlowIn,
                    ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _reviewController,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Review',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  validator: (value) {
                    if (value.toString().isEmpty) {
                      return 'Review tidak boleh kosong!';
                    }
                    return null;
                  },
                )
                    .animate()
                    .fade(
                      duration: 850.ms,
                    )
                    .slideX(
                      begin: 0.3,
                      duration: 1200.ms,
                      curve: Curves.fastOutSlowIn,
                    ),
              ],
            ),
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.all(16),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        )
            .animate()
            .fade(
              duration: 850.ms,
            )
            .slideY(
              begin: 0.3,
              duration: 1200.ms,
              curve: Curves.fastOutSlowIn,
            ),
        ElevatedButton(
          onPressed: () {
            FormState? form = _formKey.currentState;

            if (form != null) {
              if (form.validate()) {
                provider
                    .postReview(
                        id: restaurantId,
                        name: _nameController.text,
                        review: _reviewController.text)
                    .then((value) {
                  if (value == ResultState.success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Berhasil menambahkan review'),
                      ),
                    );
                  }
                  Navigator.pop(context);
                });
              }
            }
          },
          child: const Text(
            'Tambah',
            style: TextStyle(color: Colors.white),
          ),
        )
            .animate()
            .fade(
              duration: 850.ms,
            )
            .slideY(
              begin: 0.3,
              duration: 1200.ms,
              curve: Curves.fastOutSlowIn,
            ),
      ],
    );
  }
}
