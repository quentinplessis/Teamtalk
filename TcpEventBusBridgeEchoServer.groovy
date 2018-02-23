import io.vertx.core.AbstractVerticle
import io.vertx.core.Vertx;
import io.vertx.core.eventbus.Message;
import io.vertx.core.json.JsonObject;
import io.vertx.ext.bridge.BridgeOptions;
import io.vertx.ext.bridge.PermittedOptions;
import io.vertx.ext.eventbus.bridge.tcp.TcpEventBusBridge;

class TcpEventBusBridgeEchoServer extends AbstractVerticle {

  @Override
  void start() throws Exception {
    println "starting"

    TcpEventBusBridge bridge = TcpEventBusBridge.create(
        vertx,
        new BridgeOptions()
            .addInboundPermitted(new PermittedOptions().setAddress("slot-demand"))
            .addOutboundPermitted(new PermittedOptions().setAddress("slot-demand"))
            .addInboundPermitted(new PermittedOptions().setAddress("slot-supply"))
            .addOutboundPermitted(new PermittedOptions().setAddress("slot-supply"))
            .addInboundPermitted(new PermittedOptions().setAddress("task-attribution"))
            .addOutboundPermitted(new PermittedOptions().setAddress("task-attribution"))
            .addInboundPermitted(new PermittedOptions().setAddress("executed-tasks"))
            .addOutboundPermitted(new PermittedOptions().setAddress("executed-tasks")));

    bridge.listen(7005, {res -> System.out.println("Ready: "+ bridge)});
  }

  @Override
  void stop() throws Exception {
    println "stopping"
  }
}

