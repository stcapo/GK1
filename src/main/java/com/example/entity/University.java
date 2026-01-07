package com.example.entity;

/**
 * 大学实体类
 */
public class University {
    private int id;
    private String name;
    private String province;
    private String city;
    private String type;
    private boolean is985;
    private boolean is211;
    private boolean isDoubleFirst;
    private String tags;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getProvince() { return province; }
    public void setProvince(String province) { this.province = province; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public boolean isIs985() { return is985; }
    public void setIs985(boolean is985) { this.is985 = is985; }

    public boolean isIs211() { return is211; }
    public void setIs211(boolean is211) { this.is211 = is211; }

    public boolean isDoubleFirst() { return isDoubleFirst; }
    public void setDoubleFirst(boolean doubleFirst) { isDoubleFirst = doubleFirst; }

    public String getTags() { return tags; }
    public void setTags(String tags) { this.tags = tags; }
}
