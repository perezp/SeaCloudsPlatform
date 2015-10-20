package eu.seaclouds.platform.planner.optimizerTest;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import eu.seaclouds.platform.planner.optimizer.heuristics.SearchMethodName;

public class DiscovererOutputTest {

 /*  private static final String OUTPUT_MM_FILENAME = "./src/test/resources/MMoutputV-15-09.yml";
   private static final String outputMMexample = "tosca_definitions_version: tosca_simple_yaml_1_0_0_wd03\ndescription: \ntemplate_name: \ntemplate_version: 1.0.0-SNAPSHOT\ntemplate_author: \n\nimports:\n  - tosca-normative-types:1.0.0.wd03-SNAPSHOT\n\ntopology_template:\n  node_templates:\n    BareMetalCloud_1gb_2_8_ghz_irwindale_36gb_scsi_15000rpm_miami_fl_usa:\n      type: seaclouds.Nodes.Compute.BareMetalCloud_1gb_2_8_ghz_irwindale_36gb_scsi_15000rpm_miami_fl_usa\n      properties:\n        resource_type: compute\n        hardwareId: \"1gb-2.8_ghz_irwindale-36gb_scsi_15000rpm\"\n        location: \"baremetalcloud:compute\"\n        region: \"miami-fl-usa\"\n        availability: 0.99999\n        country: United States\n        city: MIAMI\n        cost: 0.08 USD/hour\n        disk_size: 36\n        num_disks: 1\n        num_cpus: 1\n        ram: 1\n        disk_type: scsi";

   private static String appModel;

   static Logger log;

   @BeforeClass
   public void createObjects() {

      log = LoggerFactory.getLogger(DiscovererOutputTest.class);
   }
   
   @Test(enabled = TestConstants.EnabledTest)
   public void testPresenceHeartbeat() {
      log.info("=== TEST for RETRIEVING DATA FROM DISCOVERER  STARTED ===");

      String url = "http://131.114.3.217:1236/discoverer/fetch?oid=2775488370683472268";

      HttpClient client = new HttpClient();
      PostMethod method = new PostMethod(url);

      method.addParameter("aam", appModel);
      method.addParameter("offers", suitableCloudOffer);
      method.addParameter("optmethod", SearchMethodName.HILLCLIMB.toString());
      executeAndCheck(client, method);

      log.info("=== TEST for SOLUTION GENERATION of HILLCLIMB optimizer service FINISEHD ===");
   }
   */
   
}
