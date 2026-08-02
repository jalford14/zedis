const std = @import("std");
const Io = std.Io;
const IpAddress = std.Io.net.IpAddress;

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    const address = try IpAddress.parse("127.0.0.1", 6380);

    var server = try address.listen(io, .{
        .reuse_address = true
    });
    defer server.deinit(io);

    std.debug.print("Server listening on 127.0.0.1:6380...\n", .{});

    while(true) {
        const stream = try server.accept(io);
        defer stream.close(io);

        var stream_reader: [1024]u8 = undefined;
        stream.reader(io, stream_reader);

        
    }

// Stream.read()    → recv
// Stream.writeAll()→ send loop
// Stream.close()   → close

    var stdout_buffer: [1024]u8 = undefined;
    var stdout_file_writer: Io.File.Writer = .init(.stdout(), io, &stdout_buffer);
    const stdout_writer = &stdout_file_writer.interface;

    try stdout_writer.flush();
}
