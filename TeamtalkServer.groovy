import io.vertx.core.AbstractVerticle
import io.vertx.core.Vertx;
import io.vertx.core.eventbus.Message;
import io.vertx.core.json.JsonObject;
import io.vertx.ext.bridge.BridgeOptions;
import io.vertx.ext.bridge.PermittedOptions;
import io.vertx.ext.eventbus.bridge.tcp.TcpEventBusBridge;


class TeamtalkServer extends AbstractVerticle {

  @Override
  void start() throws Exception {

    def env = System.getenv();
    def port = env['TEAMTALK_SERVER_PORT'] ? env['TEAMTALK_SERVER_PORT'] as Integer : 8080;

    println "Starting on $port"

    // Prepare bridge options
    def addresses = [ 'slot-demand', 'slot-supply', 'task-attribution', 'executed-tasks' ];
    BridgeOptions bridgeOptions = new BridgeOptions();
    addresses.each { address ->
      bridgeOptions
        .addInboundPermitted(new PermittedOptions().setAddress(address))
        .addOutboundPermitted(new PermittedOptions().setAddress(address));
    }

    // Create and launch bridge
    TcpEventBusBridge bridge = TcpEventBusBridge.create(vertx, bridgeOptions);
    bridge.listen(port, { res ->
      System.out.println("Ready: $bridge")
    });
  }

  @Override
  void stop() throws Exception {
    println 'Stopping'
  }

}
