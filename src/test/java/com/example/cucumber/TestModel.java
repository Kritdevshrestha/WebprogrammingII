package com.example.cucumber;

import org.springframework.ui.Model;
import java.util.HashMap;
import java.util.Map;

public class TestModel implements Model {
    private final Map<String, Object> attributes = new HashMap<>();

    @Override
    public Model addAttribute(String attribute, Object value) {
        attributes.put(attribute, value);
        return this;
    }

    @Override
    public Model addAttribute(Object attributeValue) {
        return this;
    }

    @Override
    public Model addAllAttributes(Map<String, ?> attributes) {
        this.attributes.putAll(attributes);
        return this;
    }

    @Override
    public Model addAllAttributes(java.util.Collection<?> attributeValues) {
        return this;
    }

    @Override
    public Model mergeAttributes(Map<String, ?> attributes) {
        this.attributes.putAll(attributes);
        return this;
    }

    @Override
    public boolean containsAttribute(String attributeName) {
        return attributes.containsKey(attributeName);
    }

    @Override
    public Map<String, Object> asMap() {
        return new HashMap<>(attributes);
    }

    public Object getAttribute(String name) {
        return attributes.get(name);
    }
}