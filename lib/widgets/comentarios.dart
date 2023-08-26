import 'package:flutter/material.dart';

class Comment {
  final String username;
  final String content;

  Comment({required this.username, required this.content});
}

class CommentsWidget extends StatelessWidget {
  final List<Comment> comments = [
    Comment(username: 'Usuario1', content: '¡Este lugar es increíble!'),
    Comment(username: 'Usuario2', content: '¡Me encantó la comida!'),
    Comment(username: 'Usuario3', content: 'Volvería una y otra vez.'),
    // Agregar más comentarios aquí
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: comments.length,
      itemBuilder: (context, index) {
        return CommentCard(comment: comments[index]);
      },
    );
  }
}

class CommentCard extends StatelessWidget {
  final Comment comment;

  const CommentCard({required this.comment});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              comment.username,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text(
              comment.content,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
