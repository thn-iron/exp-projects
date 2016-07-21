package exp.protobuf;

import org.junit.Assert;
import org.junit.Test;
import org.junit.BeforeClass;

/**
 * AddressTest description
 */
public class AddressTest {
    private static final String ADDRESS1 = "1 Main Street";
    private static final String CITY = "City A";
    private static final AddressProto.Address.StateAbbr STATE = AddressProto.Address.StateAbbr.AA;
    private static final String ZIP = "12345";
    private static AddressProto.Address address;

    @BeforeClass
    public static void setup() {
         address = AddressProto.Address.newBuilder()
                .setAddress1(ADDRESS1)
                .setCity(CITY)
                .setState(STATE)
                .setZip(ZIP)
                .build();
    }

    @Test
    public void test() {
        Assert.assertEquals(ADDRESS1, address.getAddress1());
        Assert.assertEquals(CITY, address.getCity());
        Assert.assertEquals(STATE, address.getState());
        Assert.assertEquals(ZIP, address.getZip());
    }
}
