import 'package:afalagi/features/success_stories/domain/entities/success_story_entity.dart';
import 'package:afalagi/features/success_stories/presentation/bloc/success_story_cubit.dart';

import '../../../../../core/constants/constant.dart';
import '../../../../../core/constants/presentation_export.dart';

class SuccessStoryDetailScreen extends StatefulWidget {
  final String? storyId;

  const SuccessStoryDetailScreen({super.key, this.storyId});

  @override
  State<SuccessStoryDetailScreen> createState() =>
      _SuccessStoryDetailScreenState();
}

class _SuccessStoryDetailScreenState extends State<SuccessStoryDetailScreen> {
  late String? storyId;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as String;
    setState(() {
      storyId = args;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Fetch the success story details
    context.read<SuccessStoryCubit>().getSuccessStoryById(storyId!);

    return Scaffold(
      appBar: AppBar(title: const Text('Success Story Detail')),
      body: BlocBuilder<SuccessStoryCubit, GenericState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.isSuccess) {
            final SuccessStoryEntity story = state.data;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      story.title!,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      story.content!,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),

                    if (story.images?.isNotEmpty ?? false)
                      Column(
                        children: story.images!.map((image) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Image.network(
                                '${AppConstant.UPLOAD_BASE_URL}/successStory/$image'),
                          );
                        }).toList(),
                      ),

                    // Additional details about the success story
                    if (story.closedCase != null) ...[
                      const SizedBox(height: 10),
                      Text(
                          'Found Condition: ${story.closedCase!.foundCondition ?? 'Unknown'}'),
                      Text(
                          'Found Date: ${story.closedCase!.foundDate ?? 'Unknown'}'),
                      Text(
                          'Found Location: ${story.closedCase!.foundLocation ?? 'Unknown'}'),
                      Text(
                          'Found Through: ${story.closedCase!.foundThrough ?? 'Unknown'}'),
                    ],
                  ],
                ),
              ),
            );
          }

          return const Center(child: Text('Error loading story.'));
        },
      ),
    );
  }
}
