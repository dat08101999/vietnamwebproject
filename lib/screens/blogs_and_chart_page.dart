import 'package:flutter/material.dart';
import 'package:flutter_back_end/configs/config_mywebvietnam.dart';
import 'package:flutter_back_end/controllers/blogs_and_chart_controller.dart';
import 'package:flutter_back_end/models/blog.dart';
import 'package:flutter_back_end/models/request_dio.dart';
import 'package:flutter_back_end/widgets/widget_blog.dart';
import 'package:flutter_back_end/widgets/widget_chart.dart';
import 'package:flutter_back_end/widgets/widget_chart_month.dart';
import 'package:get/get.dart';

class BlogsAndChart extends StatefulWidget {
  @override
  _BlogsAndChartState createState() => _BlogsAndChartState();
}

class _BlogsAndChartState extends State<BlogsAndChart> {
  BlogsAndChartController _blogsAndChartController;

  @override
  void initState() {
    super.initState();
    _blogsAndChartController = Get.put(BlogsAndChartController());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            ChartMonth(),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (ctlScroll) {
                  if (ctlScroll is ScrollEndNotification) if (ctlScroll
                          .metrics.pixels ==
                      ctlScroll.metrics.maxScrollExtent) {
                    if (_blogsAndChartController.limit < 80) {
                      _blogsAndChartController.limit = 10;
                    }
                    return true;
                  }
                  return false;
                },
                child: _buildBlogs(),
              ),
            )
          ],
        ));
  }
}

Widget _buildBlogs() {
  return GetBuilder<BlogsAndChartController>(builder: (ctl) {
    return FutureBuilder(
        future: getBlogs(limit: ctl.limit),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Blog> blogs = snapshot.data;
            return ListView.builder(
                itemCount: blogs.length,
                itemBuilder: (context, index) {
                  if (index == blogs.length) {
                    return Card(
                      child: ListTile(
                        leading: CircularProgressIndicator(),
                        title: Text(
                          'Đang tải ...',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }
                  return WidgetBlog(blog: blogs[index]);
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  });
}

Future<List<Blog>> getBlogs({int limit = 0}) async {
  // var token = await User.getToken();
  var paramas = {
    'token': '4779ce0e8eeb2de09fd04dd38c7d0526',
    'limit': 10 + limit
  };
  var response =
      await RequestDio.get(url: ConfigsMywebvietnam.getBlogs, parames: paramas);
  if (response['success']) {
    List blogs = response['data'];
    return List.generate(blogs.length, (index) => Blog.fromMap(blogs[index]));
  } else {
    print('lấy dữ liệu lỗi');
    return null;
  }
}
