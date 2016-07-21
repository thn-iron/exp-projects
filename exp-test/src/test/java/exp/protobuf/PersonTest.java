package exp.protobuf;

import exp.protobuf.PersonProto;
import exp.protobuf.AddressProto;

import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.Test;

/**
 * PersonTest description
 */
public class PersonTest {
    private static PersonProto.Person person;

    private static final String FIRST_NAME = "FName";
    private static final String LAST_NAME = "LName";
    private static final int AGE = 30;

    private static final String ADDRESS1 = "1 Main Street";
    private static final String CITY = "City A";
    private static final AddressProto.Address.StateAbbr STATE = AddressProto.Address.StateAbbr.AA;
    private static final String ZIP = "12345";

    @BeforeClass
    public static void setup() {
        final AddressProto.Address address = AddressProto.Address.newBuilder()
                .setAddress1(ADDRESS1)
                .setCity(CITY)
                .setState(STATE)
                .setZip(ZIP)
                .build();

        person = PersonProto.Person.newBuilder()
                .setFirstName(FIRST_NAME)
                .setLastName(LAST_NAME)
                .setAge(AGE)
                .setAddressInfo(address)
                .build();
    }

    @Test
    public void test() {
        Assert.assertEquals(FIRST_NAME, person.getFirstName());
        Assert.assertEquals(LAST_NAME, person.getLastName());
        Assert.assertEquals(AGE, person.getAge());

        final AddressProto.Address address = person.getAddressInfo();
        Assert.assertEquals(ADDRESS1, address.getAddress1());
        Assert.assertEquals(CITY, address.getCity());
        Assert.assertEquals(STATE, address.getState());
        Assert.assertEquals(ZIP, address.getZip());
    }
}
