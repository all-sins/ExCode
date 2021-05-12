import icmplib

ping_object = icmplib.ping("8.8.8.8", 10, 1, 2)

print("Max:", ping_object.max_rtt, "ms\n" +
      "Min:", ping_object.min_rtt, "ms\n" +
      "Dropped Packets:", ping_object.packet_loss, "\n" +
      "Average Latency:", ping_object.avg_rtt, "ms")
