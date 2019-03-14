class Lesson {
  String title;
  String box_label;
  String client_name;
  String address;
  String status;
  int color;

  Lesson(
      {this.title, this.box_label, this.client_name, this.address, this.status, this.color});

  List getLessons() {
    return [
      Lesson(
          title: "18 - 1234",
          box_label: "Box Label",
          client_name: "John Doe",
          address: "KL, Malaysia.",
          status: "Delivered",
          color: 0xFF009933),
      Lesson(
          title: "18 - 1234",
          box_label: "Box Label",
          client_name: "John Doe",
          address: "KL, Malaysia.",
          status: "Cancelled",
          color: 0xFFff0000),
      
      Lesson(
          title: "18 - 1234",
          box_label: "Box Label",
          client_name: "John Doe",
          address: "KL, Malaysia.",
          status: "Pending",
          color: 0xFFff8b54),
      Lesson(
          title: "18 - 1234",
          box_label: "Box Label",
          client_name: "John Doe",
          address: "KL, Malaysia.",
          status: "Delivered",
          color: 0xFF009933),
      Lesson(
          title: "18 - 1234",
          box_label: "Box Label",
          client_name: "John Doe",
          address: "KL, Malaysia.",
          status: "Cancelled",
          color: 0xFFff0000),
      
      Lesson(
          title: "18 - 1234",
          box_label: "Box Label",
          client_name: "John Doe",
          address: "KL, Malaysia.",
          status: "Pending",
          color: 0xFFff8b54),
          
      ];
  }
}
