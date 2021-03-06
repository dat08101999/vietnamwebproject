import 'package:flutter/material.dart';

import 'package:flutter_back_end/models/blog.dart';

class WidgetBlog extends StatelessWidget {
  final Blog blog;

  WidgetBlog({
    Key key,
    this.blog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: ListTile(
          leading: AspectRatio(
            aspectRatio: 2 / 1,
            child: Image.network(
              blog.thumbnail,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                return progress == null
                    ? child
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(5)),
                      );
              },
            ),
          ),
          title: Text(
            blog.name,
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            '${blog.addedDate} - ${blog.categories['name']}',
            style: TextStyle(color: Colors.black54),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}

// Container(
//   decoration: BoxDecoration(
//       color: Colors.grey.withOpacity(0.5),
//       borderRadius: BorderRadius.circular(5)),
// );

// Center(
//   child: CircularProgressIndicator(
//     value: progress.expectedTotalBytes != null
//         ? progress.cumulativeBytesLoaded /
//             progress.expectedTotalBytes
//         : null,
//   ),
// );
